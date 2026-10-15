-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_user_activity_aid
-- Type: INDEX

-- Name: ix_upp_user_activity_aid; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_user_activity_aid ON upp.upp_user_activity USING btree (user_id);


--
