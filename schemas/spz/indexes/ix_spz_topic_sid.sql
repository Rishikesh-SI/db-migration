-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_topic_sid
-- Type: INDEX

-- Name: ix_spz_topic_sid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_topic_sid ON spz.spz_topic USING btree (sport_id);


--
