-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_topic_sid
-- Type: INDEX

-- Name: ix_khi_topic_sid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_topic_sid ON khi.khi_topic USING btree (sport_id);


--
