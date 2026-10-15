-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_user_activity_aid
-- Type: INDEX

-- Name: ix_isl_user_activity_aid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_user_activity_aid ON isl.isl_user_activity USING btree (user_id);


--
