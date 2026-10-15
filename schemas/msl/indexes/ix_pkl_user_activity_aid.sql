-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: ix_pkl_user_activity_aid
-- Type: INDEX

-- Name: ix_pkl_user_activity_aid; Type: INDEX; Schema: msl; Owner: -
--

CREATE INDEX ix_pkl_user_activity_aid ON msl.msl_user_activity USING btree (user_id);


--
