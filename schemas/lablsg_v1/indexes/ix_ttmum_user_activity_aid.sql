-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: ix_ttmum_user_activity_aid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aid; Type: INDEX; Schema: lablsg_v1; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aid ON lablsg_v1.lablsg_v1_user_activity USING btree (user_id);


--
