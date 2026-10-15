-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_user_activity_aid
-- Type: INDEX

-- Name: ix_user_activity_aid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_user_activity_aid ON upy.upy_user_activity USING btree (user_id);


--
