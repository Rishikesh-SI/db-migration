-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_user_activity_aid
-- Type: INDEX

-- Name: ix_user_activity_aid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_user_activity_aid ON gsf.gsf_user_activity USING btree (user_id);


--
