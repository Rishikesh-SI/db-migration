-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_topic_sid
-- Type: INDEX

-- Name: ix_upy_topic_sid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_topic_sid ON upy.upy_topic USING btree (sport_id);


--
