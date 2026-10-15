-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_topic_sid
-- Type: INDEX

-- Name: ix_scom_topic_sid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_topic_sid ON scom.scom_topic USING btree (sport_id);


--
