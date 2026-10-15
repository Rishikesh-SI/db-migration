-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_user_activity_aid
-- Type: INDEX

-- Name: ix_hsl_user_activity_aid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_user_activity_aid ON hsl.hsl_user_activity USING btree (user_id);


--
