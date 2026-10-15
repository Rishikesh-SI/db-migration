-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: ix_ttmum_user_activity_aid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aid; Type: INDEX; Schema: labmsg; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aid ON labmsg.labmsg_user_activity USING btree (user_id);


--
