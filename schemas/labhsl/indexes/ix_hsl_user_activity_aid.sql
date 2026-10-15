-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_user_activity_aid
-- Type: INDEX

-- Name: ix_hsl_user_activity_aid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_user_activity_aid ON labhsl.labhsl_user_activity USING btree (user_id);


--
