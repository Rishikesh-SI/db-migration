-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_user_role_rid
-- Type: INDEX

-- Name: ix_pkl_user_role_rid; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_user_role_rid ON gfg.gfg_user_role USING btree (role_id);


--
