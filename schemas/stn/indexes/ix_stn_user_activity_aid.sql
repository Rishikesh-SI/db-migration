-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_user_activity_aid
-- Type: INDEX

-- Name: ix_stn_user_activity_aid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_user_activity_aid ON stn.stn_user_activity USING btree (user_id);


--
