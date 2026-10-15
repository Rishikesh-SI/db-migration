-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_user_uname
-- Type: INDEX

-- Name: ix_pkl_user_uname; Type: INDEX; Schema: gfg; Owner: -
--

CREATE UNIQUE INDEX ix_pkl_user_uname ON gfg.gfg_user USING btree (user_name);


--
