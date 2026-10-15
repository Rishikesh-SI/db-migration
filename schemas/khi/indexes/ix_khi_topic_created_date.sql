-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_topic_created_date
-- Type: INDEX

-- Name: ix_khi_topic_created_date; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_topic_created_date ON khi.khi_topic USING btree (created_date);


--
