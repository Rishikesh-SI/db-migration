-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_user_activity_aid
-- Type: INDEX

-- Name: ix_user_activity_aid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_user_activity_aid ON rfg.rfg_user_activity USING btree (user_id);


--
