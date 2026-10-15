-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_user_activity_aid
-- Type: INDEX

-- Name: ix_user_activity_aid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_user_activity_aid ON scom.scom_user_activity USING btree (user_id);


--
