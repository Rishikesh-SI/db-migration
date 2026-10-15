-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_topic_created_date
-- Type: INDEX

-- Name: ix_swa_topic_created_date; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_topic_created_date ON swa.swa_topic USING btree (created_date);


--
