%option noyywrap

%{

#include "lurch.h"

int _s = 0, _1st = _FALSE, _m = 0, _id = 0, _nv = _FALSE;
int _wt = 0, _max_wt = 0, _min_wt = 0;
int _new = _FALSE, _ns = -1;
_State *_states = NULL, *_st = NULL;
_Tran *_transitions = NULL, *_tr = NULL;
_Sptr *_ends = NULL;
_Sptr *_locals = NULL;
_Sptr *_progs = NULL;
_Sptr *_accs = NULL;
int _i = 500;
int _d = 500;
unsigned int _seed = 0;
int _a = _FALSE;
_Flt *_faults = NULL;
int _last_prog = -1;
int _last_acc = -1;
int _quit = _FALSE;
_Gstate *_gstates = NULL;
int _gscount = 1;
int _in_npcycle = _FALSE;
int _in_accycle = _FALSE;
unsigned int _which_npcycle = 0;
unsigned int _which_accycle = 0;
_Eptr *_npescapes = NULL;
_Eptr *_accescapes = NULL;
int _colmax = 50;
int _col = 0;
unsigned int _gsnew = 1;
unsigned int _gsall = 1;
float _sat = 100.0;
float _satmin = 0.01;
int _l = _FALSE;
int _n = _FALSE;
int _v = _FALSE;
int _o = _FALSE;
int _k = _FALSE;
int _t = 0;
int _T = _FALSE;
int _which_npdepth = 0;
int _which_acdepth = 0;
int _which_nplen = 0;
int _which_aclen = 0;
int _iter = 0;
float _time = 0;
int _clock_overs = 0;
int _q = _FALSE;
float _states_count = 0;
float _mem = 0;
int _p = _FALSE;

char _c[_MAX_NAME];
char _status[_MAX_NAME];
_Hptr *_gstall[_GSTALL_SIZE];

_State *_stalloc(char *c, int m, int *s)
{
  _State *st = (_State *) malloc(sizeof(_State));

  if (st)
    {
      st->c = (char *) malloc(strlen(c) + 1);
      strcpy(st->c, c);
      st->m = m;
      st->s = (*s)++;
      st->next = NULL;
    }

  return st;
}

_State *_add_state(char *c, int m, int *s)
{
  _State *st;

  if (!_states) return _states = _stalloc(c, m, s);

  for (st = _states; st; st = st->next)
    if (!strcmp(st->c, c))
      {
	if (st->m == -1) { st->m = m; st->s = (*s)++; }
	return st;
      }
    else if (!st->next) return st->next = _stalloc(c, m, s);
}

_Tran *_tralloc(_State *par, int id, int nv, int wt)
{
  _Tran *tr = (_Tran *) malloc(sizeof(_Tran));
  tr->par = par;
  tr->in = tr->out = NULL;
  tr->kid = NULL;
  tr->id = id;
  tr->nv = nv;
  tr->wt = wt;
  tr->ct = 0;
  tr->bias = 1;
  tr->qwt = 1.0;
  tr->next = NULL;
  return tr;
}

_Tran *_add_tran(_State *par, int id, int nv, int wt)
{
  _Tran *tr;

  if (!_transitions) return _transitions = _tralloc(par, id, nv, wt);

  for (tr = _transitions; tr; tr = tr->next)
    if (!tr->next) return tr->next = _tralloc(par, id, nv, wt);
}

_Sptr *_spalloc(_State *st)
{
  _Sptr *sp = (_Sptr *) malloc(sizeof(_Sptr));
  sp->st = st;
  sp->next = NULL;
  return sp;
}

void _add_sptr(_Sptr **sptrs, _State *st)
{
  _Sptr *sp;

  if (!*sptrs) *sptrs = _spalloc(st);

  for (sp = *sptrs; sp; sp = sp->next)
    if (sp->st == st) return;
    else if (!sp->next) sp->next = _spalloc(st);
}

_Tptr *_tpalloc(_Tran *tr)
{
  _Tptr *tp = (_Tptr *) malloc(sizeof(_Tptr));
  tp->tr = tr;
  tp->next = NULL;
  return tp;
}

void _add_tptr(_Tptr **tptrs, _Tran *tr)
{
  _Tptr *tp;

  if (!*tptrs) *tptrs = _tpalloc(tr);

  for (tp = *tptrs; tp; tp = tp->next)
    if (tp->tr == tr) return;
    else if (!tp->next) tp->next = _tpalloc(tr);
}

_Flt *_falloc(char *c, unsigned int h, int d, unsigned int s, int l)
{
  _Flt *f = (_Flt *) malloc(sizeof(_Flt));
  strcpy(f->name, c);
  f->h = h;
  f->depth = d;
  f->seed = s;
  f->len = l;
  f->iter = _iter;
  f->times = 1;
  f->next = NULL;
  return f;
}

int _add_flt(char *c, unsigned int h, int d, unsigned int s, int l)
{
  _Flt *f;

  if (!_faults)
    {
      _faults = _falloc(c, h, d, s, l);
      return _TRUE;
    }

  for (f = _faults; f; f = f->next)
    if (!strcmp(f->name, c) && (f->h == h))
      {
	if (f->iter != _iter)
	  {
	    f->iter = _iter;
	    (f->times)++;
	  }

	if (f->len > l)
	  {
	    f->depth = d;
	    f->seed = s;
	    f->len = l;
	    return _TRUE;
	  }
	else return _FALSE;
      }
    else if (!f->next)
      {
	f->next = _falloc(c, h, d, s, l);
	return _TRUE;
      }
}

_Gstate *_gsalloc(unsigned int h, int d)
{
  _Gstate *gs = (_Gstate *) malloc(sizeof(_Gstate));
  gs->h = h;
  gs->depth = d;
  gs->n = -1;
  gs->left = NULL;
  gs->right = NULL;
  return gs;
}

_Gstate *_add_gstate(_Gstate **gs, unsigned int h, int d)
{
  if (!*gs)
    return *gs = _gsalloc(h, d);

  if ((*gs)->h == h)
    {
      ((*gs)->n)++;
      return *gs;
    }
  else if ((*gs)->h > h)
    return _add_gstate(&((*gs)->left), h, d);
  else return _add_gstate(&((*gs)->right), h, d);
}

void _free_gstates(_Gstate **gs)
{
  if (!*gs) return;
  if ((*gs)->left) _free_gstates(&((*gs)->left));
  if ((*gs)->right) _free_gstates(&((*gs)->right));
  free(*gs);
  *gs = NULL;
}

_Hptr *_hpalloc(unsigned int h)
{
  _Hptr *hp = (_Hptr *) malloc(sizeof(_Hptr));
  hp->h = h;
#ifdef GS
  hp->i = 1;
  hp->j = 0;
#endif
  hp->left = NULL;
  hp->right = NULL;
  return hp;
}

int _add_hptr(_Hptr **hp, unsigned int h, int j)
{
  if (!*hp)
    {
      *hp = _hpalloc(h);
      _states_count++;
      return _TRUE;
    }

  if ((*hp)->h == h)
    {
#ifdef GS
      ((*hp)->i)++;
      ((*hp)->j) = j;
#endif
      return _FALSE;
    }
  else if ((*hp)->h > h)
    return _add_hptr(&((*hp)->left), h, j);
  else return _add_hptr(&((*hp)->right), h, j);
}

_Eptr *_epalloc(unsigned int h)
{
  _Eptr *ep = (_Eptr *) malloc(sizeof(_Eptr));
  ep->h = h;
  ep->next = NULL;
  return ep;
}

int _add_eptr(_Eptr **eptrs, unsigned int h)
{
  _Eptr *ep;

  if (!*eptrs)
    {
      *eptrs = _epalloc(h);
      return _TRUE;
    }

  for (ep = *eptrs; ep; ep = ep->next)
    if (ep->h == h) return _FALSE;
    else if (!ep->next)
      {
	ep->next = _epalloc(h);
	return _TRUE;
      }
}

%}

%x IN
%x OUT
%x KID

%%

[ \t]+                  { }
\n+                     { _s = 0; if (!_1st) _m++; }
n:[ \t]*                { _nv = _TRUE; }
-?[0-9]+:[ \t]*         { yytext[strlen(yytext) - 1] = '\0';
                          _wt = atoi(yytext);
			  if (_wt > _max_wt) _max_wt = _wt;
			  else if (_wt < _min_wt) _min_wt = _wt;
                        }
[^.:;\n]+               { _1st = _FALSE;
                          _st = _add_state(strcpy(_c, yytext), _m, &_s);
			  if (*_c == '_') _add_sptr(&_locals, _st);
			  else if (*_c == '#') _add_sptr(&_progs, _st);
			  else if (*_c == '=') _add_sptr(&_accs, _st);
                        } 
;[ \t]*\n               { }
\.[ \t]*\n              { _add_sptr(&_ends, _st); }
\;                      { _tr = _add_tran(_st, ++_id, _nv, _wt);
                          _nv = _FALSE; _wt = 0;
                          BEGIN IN;
                        }
\.                      { _add_sptr(&_ends, _st);
                          _tr = _add_tran(_st, ++_id, _nv, _wt);
                          _nv = _FALSE; _wt = 0;
                          BEGIN IN;
                        }

<IN>[ \t,]+             { }
<IN>[^,.; ]+            { if (strcmp("-", yytext))
                            _add_sptr(&(_tr->in), _add_state(yytext, -1, &_ns));
                        } 
<IN>;                   { BEGIN OUT; }

<OUT>[ \t,]+            { }
<OUT>[^,; ]+            { if (strcmp("-", yytext))
                            _add_sptr(&(_tr->out), _add_state(yytext, -1, &_ns));
                        } 
<OUT>;                  { BEGIN KID; }

<KID>[ \t]+             { }
<KID>[^.; ]+            { _tr->kid = _add_state(strcpy(_c, yytext), _m, &_s);
			  if (*_c == '_') _add_sptr(&_locals, _tr->kid);
			  else if (*_c == '#') _add_sptr(&_progs, _tr->kid);
			  else if (*_c == '=') _add_sptr(&_accs, _tr->kid);
                        }
<KID>;[ \t]*\n          { BEGIN INITIAL; }
<KID>\.[ \t]*\n         { _add_sptr(&_ends, _tr->kid); BEGIN INITIAL; }
<KID>.                  { }

%%

void _set_m_and_wts(void)
{
  _Tran *tr;
  _m = 0;
  _max_wt++;

  for (tr = _transitions; tr; tr = tr->next)
    {
      if (tr->par->m > _m) _m = tr->par->m;
      if (tr->nv) tr->wt = _max_wt;
    }

  _m++;
}

/* int returned from 0...max */
/* no longer used in _random_push(), but kept so it's available to input models */
int _next_int(int max)
{
  int i, j;

  do j = (i = rand()) % (max + 1);
  while (i - j + max < 0);

  return j;
}

float _next_float()
{
  return ((float) rand() / RAND_MAX);
}

void _random_push(_Tptr **q, int *ql, _Tran *tr)
{
  int i;
  float f;
  _Tptr *tp, *new;

  /* high bias means lower qwt, which puts you near front of queue */
  if (tr->bias > 0)
    {
      tr->qwt = 1.0;

      for (i = 0; i < tr->bias; i++)
	if ((f = _next_float()) < tr->qwt)
	  tr->qwt = f;
    }
  /* low bias means higher qwt, which puts you near back of queue */
  else if (tr->bias < 0)
    {
      tr->qwt = 0.0;

      for (i = 0; i < (-1 * (tr->bias)); i++)
	if ((f = _next_float()) > tr->qwt)
	  tr->qwt = f;
    }
  /* zero bias means leave this transition out of queue */
  else return;

  (*ql)++;
  new = _tpalloc(tr);

  if (!(*q) || ((*q)->tr->qwt >= tr->qwt))
    {
      new->next = *q;
      *q = new;
    }
  else
    {
      for (tp = *q; (tp->next && (tp->next->tr->qwt < tr->qwt)); tp = tp->next);
      if (tp->next) new->next = tp->next;
      tp->next = new;
    }
}

_Tran *_pop(_Tptr **q, int *ql)
{
  _Tran *tr = (*q)->tr;
  _Tptr *tp = *q;

  *q = (*q)->next;
  (*ql)--;
  free(tp);
  tp = NULL;
  return tr;
}

void _exec(_Tran *tr, int *state)
{
  _Sptr *sp;

  for (sp = tr->out; sp; sp = sp->next)
    state[sp->st->m] = sp->st->s;

  state[tr->kid->m] = tr->kid->s;

  _out(tr->id); /* trans.c */
  _tr_incr(tr); /* trans.c */
}

void _astep(_Tptr **q, int *ql, int *state)
{
  _Tran *tr = _pop(q, ql);

  _exec(tr, state);
  while(*ql) _pop(q, ql);
}

void _step(_Tptr **q, int *ql, int *state, int *dq, int k)
{
  _Tran *tr;
  
  while (*ql)
    if ((tr = _pop(q, ql)) && (dq[tr->par->m] != k))
      {
	_exec(tr, state);
	dq[tr->par->m] = k;
      }
}

void _hash_string(char *c, unsigned int *h)
{
  int i;
  while (i = *c++) *h = i + (*h << 6) + (*h << 16) - *h;
}

void _hash_int(int i, unsigned int *h)
{
  char c[16];
  sprintf(c, "%i", i); _hash_string(c, h);
}

unsigned int _hash_state(int *state)
{
  unsigned int h = 0;
  int i;
  char c[(7*_m) + 1], d[8];

  *c = *d = '\0';

  for (i = 0; i < _m; i++)
    {
      sprintf(d, "%i ", state[i]);
      strcat(c, d);
    }

  _hash_string(c, &h);
  _hash(&h); /* trans.c */

  return h;
}

float _my_clock(void)
{
  float f;
  return (f = clock())/CLOCKS_PER_SEC;
}

void _stats(int i)
{
  float fl;
  char c[24];
  FILE *f = NULL;

  if (!_p)
    {
      printf("\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b");
      printf("\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b");
    }

  if (f = fopen(_status, "r"))
    {
      while (fscanf(f, "%s", c) != EOF)
	if (!strcmp(c, "VmRSS:")) /* label in /proc/#/status */
	  {
	    fscanf(f, "%s", c);
	    break;
	  }

      fclose(f);
      if ((fl = (atof(c) / 1024)) > _mem) _mem = fl;
    }

  if (_p) printf("\n");
  printf("%8.2f %6.2f ", (fl = _my_clock()), _mem);

  if (_satmin)
    if (i == _PROG_STATS)
      if (fl > 0) printf("%9.1e  %6.1e %6.1f", _states_count, (_states_count / fl), _sat);
      else printf("%9.1e  %6.1e %6.1f", _states_count, 0, _sat);
    else
      if (fl > 0) printf("%9.1e  %6.1e", _states_count, (_states_count / fl));
      else printf("%9.1e  %6.1e", _states_count, 0); 

  if (_colmax) printf(" %5i", _col);
  fflush(stdout);
}

void _local_check(int *state, int d)
{
  int i;
  _Sptr *sp;

  for (sp = _locals; sp; sp = sp->next)
    for (i = 0; i < _m; i++) 
      if ((sp->st->m == i) && (sp->st->s == state[i]))
	{
	  if (_add_flt(sp->st->c, 0, d, _seed, d))
	    {
	      _stats(_PROG_STATS);
	      printf(" %6i    %s", d, sp->st->c);
	      if (!_p) printf("\n");
	      if (_q) _quit = _TRUE;
	    }

	  break;
	}

  if (_l)
    for (sp = _progs; sp; sp = sp->next)
      for (i = 0; i < _m; i++)
	if ((sp->st->m == i) && (sp->st->s == state[i]))
	  {
	    _last_prog = d;
	    break;
	  }

  if (_n)
    for (sp = _accs; sp; sp = sp->next)
      for (i = 0; i < _m; i++)
	if ((sp->st->m == i) && (sp->st->s == state[i]))
	  {
	    _last_acc = d;
	    break;
	  }
}

int _check_reported_cycles(char *name, unsigned int h)
{
  _Flt *ft;

  for (ft = _faults; ft; ft = ft->next)
    if (!strncmp(ft->name, name, 2) && (ft->h == h)) return _FALSE;

  return _TRUE;
}

int _check_escapes(_Eptr *escapes, unsigned int h)
{
  _Eptr *ep;

  for (ep = escapes; ep; ep = ep->next)
    if (ep->h == h) return _FALSE;

  return _TRUE;
}

int _cycle_check(int *state, int d, unsigned int h)
{
  _Gstate *gs = _add_gstate(&_gstates, h, d);

  if (gs->depth < d)
    {
      if (_l)
	if (!_in_npcycle && (gs->depth > _last_prog))
	  {
	    _in_npcycle = _TRUE;
	    _which_npcycle = h;
	    _which_npdepth = gs->depth;
	    _which_nplen = d;
	  }
	else if (_in_npcycle && (_last_prog == d))
	  {
	    if (_add_eptr(&_npescapes, _which_npcycle)
		&& !_check_reported_cycles("npcycle", _which_npcycle))
	      {
		_stats(_PROG_STATS);
		printf(" %6i    escape  (%u)", d, _which_npcycle);
		if (!_p) printf("\n");
	      }

	    _in_npcycle = _FALSE;
	  }

      if (_n)
	if (!_in_accycle && (_last_acc == d))
	  {
	    _in_accycle = _TRUE;
	    _which_accycle = h;
	    _which_acdepth = gs->depth;
	    _which_aclen = d;
	  }
	else if (_in_accycle && (gs->depth > _last_acc))
	  {
	    if (_add_eptr(&_accescapes, _which_accycle)
		&& !_check_reported_cycles("accycle", _which_accycle))
	      {
		_stats(_PROG_STATS);
		printf(" %6i    escape  (%u)", d, _which_accycle);
		if (!_p) printf("\n");
	      }

	    _in_accycle = _FALSE;
	  }
    }
  else
    {
      if (_l && _in_npcycle)
	{
	  if (_add_eptr(&_npescapes, _which_npcycle)
	      && !_check_reported_cycles("npcycle", _which_npcycle))
	    {
	      _stats(_PROG_STATS);
	      printf(" %6i    escape  (%u)", d, _which_npcycle);
	      if (!_p) printf("\n");
	    }

	  _in_npcycle = _FALSE;
	}

      if (_n && _in_accycle)
	{
	  if (_add_eptr(&_accescapes, _which_accycle)
	      && !_check_reported_cycles("accycle", _which_accycle))
	    {
	      _stats(_PROG_STATS);
	      printf(" %6i    escape  (%u)", d, _which_accycle);
	      if (!_p) printf("\n");
	    }

	  _in_accycle = _FALSE;
	}
    }

  gs->depth = d;
  if (gs->n > _col) _col = gs->n;
  if (_colmax && (_col >= _colmax)) return _FALSE;
  return _TRUE;
}

int _sat_check(int *state, unsigned int h, int j)
{
  if (_add_hptr(&(_gstall[h/(UINT_MAX/_GSTALL_SIZE)]), h, j)) _gsnew++;
  if ((_sat = ((float) _gsnew / ++_gsall) * 100) < _satmin) return _FALSE;
  return _TRUE;
}

void _deadlock_check(int *state, int d, unsigned int h)
{
  int i;
  _Sptr *sp;
  char c[_MAX_NAME];
  
  for (i = 0; i < _m; i++)
    {
      for (sp = _ends; sp; sp = sp->next)
	if ((sp->st->m == i) && (sp->st->s == state[i])) break;

      if (!sp)
	{
	  sprintf(c, "deadlock", h);

	  if (_add_flt(c, h, d, _seed, d))
	    {
	      _stats(_PROG_STATS);
	      printf(" %6i    deadlock (%u)", d, h);
	      if (!_p) printf("\n");
	    }

	  if (_q) _quit = _TRUE;

	  break;
	}
    }
}

void _lookup_name(char *c, int m, int s)
{
  _State *st;

  for (st = _states; st; st = st->next)
    if ((st->m == m) && (st->s == s))
      {
	strcpy(c, st->c);
	break;
      }
}

void _trace_files(void)
{
  _Flt *ft;
  FILE *f;
  int i, j, k, state[_m], dq[_m], ql[_max_wt - _min_wt + 1], prev[_m];
  int np = _FALSE, ac = _FALSE, escape = _FALSE;
  _Tran *tr = NULL;
  _Tptr *q[_max_wt - _min_wt + 1];
  char c[_MAX_NAME], d[_MAX_NAME], e[_MAX_PRINT];
  _Hptr *hp;
  int first = _TRUE;
  int changed;
  _Sptr *sp;
  unsigned int h;

  /* _before_all(); */ /* trans.c */

  for (i = 0; i < (_max_wt - _min_wt + 1); i++)
    {
      ql[i] = 0;
      q[i] = NULL;
    }

  for (ft = _faults; ft; ft = ft->next)
    {
      np = ac = escape = _FALSE;

      if (!strncmp(ft->name, "np", 2))
	{
	  np = _TRUE;
	  escape = !_check_escapes(_npescapes, ft->h);
	}
      else if (!strncmp(ft->name, "ac", 2))
	{
	  ac = _TRUE;
	  escape = !_check_escapes(_accescapes, ft->h);
	}

      if (!escape)
	{
	  _before(); /* trans.c */

	  sprintf(c, "%s/%s", _CE_DIR, ft->name);

	  if (ft->h)
	    {
	      sprintf(d, "_%u", ft->h);
	      strcat(c, d);
	    }

	  if (first)
	    {
	      first = _FALSE;
	      printf("\n\n");
	    }

	  printf("    writing %s (%i)\n", c, ft->times);

	  f = fopen(c, "w");
	  srand(ft->seed);
	  for (j = 0; j < _m; j++) state[j] = dq[j] = prev[j] = 0;
	  fprintf(f, "0------------------------\n\n");
	  *e = '\0'; _print(e); fprintf(f, "%s", e); /* trans.c */

	  for (j = 0; j < _m; j++)
	    {
	      _lookup_name(c, j, state[j]);
	      fprintf(f, "   %s\n", c);
	    }
	
	  for (j = 1; j <= ft->len; j++)
	    {
              _before_each(); /* trans.c */
            
	      for (k = 0; k < (_max_wt - _min_wt + 1); k++)
		{
		  for (tr = _transitions; tr; tr = tr->next)
		    if ((tr->wt == k) && (state[tr->par->m] == tr->par->s))
		      {
			for (sp = tr->in; sp; sp = sp->next)
			  if (state[sp->st->m] != sp->st->s) break;

			if (!sp && _in(tr->id))
			  _random_push(&q[k], &ql[k], tr);
		      }

		  if (q[k])
		    {
		      if (_a) _astep(&q[k], &ql[k], state);
		      else _step(&q[k], &ql[k], state, dq, j);
		    }
		}

	      fprintf(f, "\n%i------------------------\n\n", j);
	      *e = '\0'; _print(e); fprintf(f, "%s", e); /* trans.c */
              changed = _FALSE;

	      for (k = 0; k < _m; k++)
		{
		  if (state[k] != prev[k])
		    {
		      _lookup_name(c, k, prev[k]);
		      fprintf(f, "   %s ->", c);
		      _lookup_name(c, k, state[k]);
		      fprintf(f, " %s\n", c);
		      prev[k] = state[k];
                      changed = _TRUE;
		    }
		}
                
	      if ((_v && (j < ft->len)) || (j == ft->len))
		{
                  if (changed) fprintf(f, "\n");
                
		  for (k = 0; k < _m; k++)
		    {
		      _lookup_name(c, k, state[k]);
		      fprintf(f, "   %s\n", c);
		    }

		  fprintf(f, "\n");
		}
                
              _after_each(); /* trans.c */
	    }

	  if (np) fprintf(f, "   npcycle to %i\n", ft->depth);
	  if (ac) fprintf(f, "   accycle to %i\n", ft->depth);
	  _sat_check(state, h, 1);
	  fclose(f);
	  _after(); /* trans.c */
	}
    }
  
  _after_all(); /* trans.c */
}

void _report_cycles(void)
{
  if (_in_npcycle)
    {
      if (_check_escapes(_npescapes, _which_npcycle)
	  && _add_flt("npcycle", _which_npcycle, _which_npdepth, _seed, _which_nplen))
	{
	  _stats(_PROG_STATS);
	  printf(" %6i    npcycle (%u)   (%i)", _which_nplen, _which_npcycle,
		 (_which_nplen - _which_npdepth));
	  if (!_p) printf("\n");
	  if (_q) _quit = _TRUE;
	}
    }

  if (_in_accycle)
    {
      if (_check_escapes(_accescapes, _which_accycle)
	  && _add_flt("accycle", _which_accycle, _which_acdepth, _seed, _which_aclen))
	{
	  _stats(_PROG_STATS);
	  printf(" %6i    accycle (%u)   (%i)", _which_aclen, _which_accycle,
		 (_which_aclen - _which_acdepth));
	  if (!_p) printf("\n");
	  if (_q) _quit = _TRUE;
	}
    }
}

void _search(void)
{
  int j, k, l, end, nv_block, state[_m], dq[_m], ql[_max_wt - _min_wt + 1];
  _Tran *tr = NULL;
  _Tptr *q[_max_wt - _min_wt + 1], *tp;
  float f;
  unsigned int h;
  _Sptr *sp;

  _before_all(); /* trans.c */

  for (j = 0; j < (_max_wt - _min_wt + 1); j++)
    {
      ql[j] = 0;
      q[j] = NULL;
    }

  for (_iter = 0; (_T || ((_i == 0) || (_iter < _i))) && !_quit; _iter++)
    {
      _before(); /* trans.c */
      srand(_seed += rand());
      for (j = 0; j < _m; j++) state[j] = dq[j] = 0;
      h = _hash_state(state);
      end = _FALSE;
      _last_prog = _last_acc = -1;
      _in_npcycle = _in_accycle = _FALSE;
      _col = 0;
      _gsnew = _gsall = 1;
      _sat = 100.0;

      for (j = 1; (!_d || (j <= _d)) && !end && !_quit; j++)
	{
          _before_each(); /* trans.c */
	  nv_block = _FALSE;
	  end = _TRUE;

	  for (k = 0; k < (_max_wt - _min_wt + 1); k++)
	    {
	      for (tr = _transitions; tr; tr = tr->next)
		if ((tr->wt == k) && (state[tr->par->m] == tr->par->s))
		  {
		    for (sp = tr->in; sp; sp = sp->next)
		      if (state[sp->st->m] != sp->st->s) break;

		    if (!sp && _in(tr->id))
		      _random_push(&q[k], &ql[k], tr);
		  }

	      /* queue debugging info */
	      /*
	      for (tp = q[0]; tp; tp = tp->next)
		printf("%i\t%i\t%f\n", tp->tr->id, tp->tr->bias, tp->tr->qwt);

	      printf("\n");
	      */

	      if (q[k])
		{
		  end = _FALSE;

		  if (_a) _astep(&q[k], &ql[k], state);
		  else _step(&q[k], &ql[k], state, dq, j);
		}
	      // if any never machine blocks, quit iteration
	      else if (_n && (k == (_max_wt - _min_wt)))
		nv_block = _TRUE;
	    }

	  if (!end)
	    {
	      _local_check(state, j);
	      h = _hash_state(state);
              /* collisions here is total for all global states in path! */ 
	      if ((_colmax || _l || _n) && !_cycle_check(state, j, h)) end = _TRUE;
	      if (_satmin && !_sat_check(state, h, 0)) end = _TRUE;
	      if (end) _report_cycles();
	      _score(); /* trans.c */
	    }
	  else if (_k) _deadlock_check(state, j-1, h);

	  if (nv_block) end = _TRUE;
	  f = _my_clock();
	  if (_t && (f >= _t)) _quit = _TRUE;

	  if (!_o && !(((int) (f * 100)) % 25))
	    {
	      _stats(_PROG_STATS);
	      printf(" %6i", (j - 1));
	    }
            
          _after_each();
	}

      _free_gstates(&_gstates);
      _after(); /* trans.c */
    }

  /* _after_all(); */ /* trans.c */
}

#ifdef GS
void _gs_out(_Hptr **gs, FILE *f)
{
  if (*gs)
    {
      _gs_out(&((*gs)->left), f);
      _gs_out(&((*gs)->right), f);
      fprintf(f, "%i\n", (*gs)->i);
    }
}

void _gs_array_out(void)
{
  int i;
  FILE *f = fopen("counts", "w");

  for (i = 0; i < _GSTALL_SIZE; i++)
    _gs_out(&(_gstall[i]), f);

  fclose(f);
}
#endif

void _ctrl_c(void)
{
  signal(SIGINT, (void *) _ctrl_c); /* in case they hit it twice */
  _quit = _TRUE;
}

int main(int argc, char **argv)
{
  int j;
  char c[_MAX_NAME];

  _i = 500;
  _d = 500;
  _colmax = 250;
  _a = _FALSE;
  _k = _FALSE;
  _l = _FALSE;
  _satmin = 0.01;
  _seed = time(0);
  _t = 0;
  _T = _FALSE;
  _n = _FALSE;
  _o = _FALSE;
  _v = _FALSE;
  _q = _FALSE;
  _p = _FALSE;

  for (argc--, argv++; argc; argc--, argv++)
    if (**argv == '-')
      {
	(*argv)++;

	switch (**argv)
	  {
	    case 'i' : _i = atoi(*++argv); argc--; break;
	    case 'd' : _d = atoi(*++argv); argc--; break;
	    case 'c' : _colmax = atoi(*++argv); argc--; break;
	    case 'a' : _a = _TRUE; break;
	    case 'k' : _k = _TRUE; break;
	    case 'l' : _l = _TRUE; break;
	    case 's' : _satmin = atof(*++argv); argc--; break;
	    case 'r' : _seed = atoi(*++argv); argc--; break;
	    case 't' : _t = atoi(*++argv); argc--; break;
	    case 'T' : _t = atoi(*++argv); argc--; _T = _TRUE; break;
	    case 'n' : _n = _TRUE; break;
	    case 'o' : _o = _TRUE; break;
	    case 'v' : _v = _TRUE; break;
	    case 'q' : _q = _TRUE; break;
	    case 'p' : _p = _TRUE; break;
	    case 'h' :
	    default  :
	      printf("\n   Lurch options:\n\n");
	      printf("   -i (500)  set max iterations: each is one global state path.\n");
	      printf("   -d (500)  set max search depth.\n");
	      printf("   -c (50)   set max times a (global) state can be present in one path.\n");
	      printf("   -s (0.01) minimum saturation percentage (%% new).\n");
	      printf("   -a (off)  run lurch in asynchronous mode.\n");
	      printf("   -k (off)  check for deadlocks.\n");
	      printf("   -l (off)  check for no-progress cycles.\n");
	      printf("   -n (off)  check for acceptance cycles.\n");
	      printf("   -v (off)  print more verbose trace files.\n");
	      printf("   -o (off)  turn off animated output.\n");
	      printf("   -t (n/a)  specify time limit in seconds.\n");
	      printf("   -r (n/a)  specify random seed.\n\n");
	      return 0;
	  }
      }

  signal(SIGINT, (void *) _ctrl_c);
  yyin = fopen("states", "r");
  yylex();
  fclose(yyin);
  _set_m_and_wts();
  for (j = 0; j < _GSTALL_SIZE; j++) _gstall[j] = NULL;

  if (!_p)
    {
      printf("\n    random seed: %u\n", _seed);
      printf("\n    time  memory  ");
      if (_satmin) printf(" states  sts/sec  %% new  ");
      if (_colmax) printf(" col  ");
      printf("depth    name    (hash value) (size)\n\n");
    }
  else printf("%u\n", _seed);

  sprintf(_status, "/proc/%d/status", getpid());

  srand(_seed += rand());
  _search();
  sprintf(c, "mkdir -p %s", _CE_DIR);
  system(c);
  _trace_files();

  _colmax = 0;
  printf("\n");
  _stats(_LAST_STATS);

  printf(" (totals)\n");
#ifdef GS
  _gs_array_out();
#endif

  return 0;
}




















