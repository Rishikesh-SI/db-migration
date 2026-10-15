-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_user_activity_aid
-- Type: INDEX

-- Name: ix_user_activity_aid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_user_activity_aid ON spz.spz_user_activity USING btree (user_id);


--
