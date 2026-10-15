-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_user_activity_aid
-- Type: INDEX

-- Name: ix_pkl_user_activity_aid; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_user_activity_aid ON gfg.gfg_user_activity USING btree (user_id);


--
