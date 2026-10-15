-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_topic_created_date
-- Type: INDEX

-- Name: ix_tfa_topic_created_date; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_topic_created_date ON tfa.tfa_topic USING btree (created_date);


--
