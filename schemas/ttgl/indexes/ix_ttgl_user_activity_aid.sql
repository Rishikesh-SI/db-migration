-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_user_activity_aid
-- Type: INDEX

-- Name: ix_ttgl_user_activity_aid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_user_activity_aid ON ttgl.ttgl_user_activity USING btree (user_id);


--
