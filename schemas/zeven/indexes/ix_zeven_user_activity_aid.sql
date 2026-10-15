-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_user_activity_aid
-- Type: INDEX

-- Name: ix_zeven_user_activity_aid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_user_activity_aid ON zeven.zeven_user_activity USING btree (user_id);


--
