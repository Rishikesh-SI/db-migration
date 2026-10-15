-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_redirect_old_alias
-- Type: INDEX

-- Name: ix_pkl_redirect_old_alias; Type: INDEX; Schema: gfg; Owner: -
--

CREATE UNIQUE INDEX ix_pkl_redirect_old_alias ON gfg.gfg_redirect USING btree (old_alias);


--
