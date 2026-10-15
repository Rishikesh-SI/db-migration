-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_user_role_uid
-- Type: INDEX

-- Name: ix_pkl_user_role_uid; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_user_role_uid ON gfg.gfg_user_role USING btree (user_id);


--
