-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_user_activity_aid
-- Type: INDEX

-- Name: ix_ppb_user_activity_aid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_user_activity_aid ON ppb.ppb_user_activity USING btree (user_id);


--
