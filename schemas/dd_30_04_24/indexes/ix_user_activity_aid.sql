-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_user_activity_aid
-- Type: INDEX

-- Name: ix_user_activity_aid; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_user_activity_aid ON dd_30_04_24.dd_user_activity USING btree (user_id);


--
