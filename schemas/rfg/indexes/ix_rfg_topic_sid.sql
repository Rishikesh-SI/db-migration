-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_topic_sid
-- Type: INDEX

-- Name: ix_rfg_topic_sid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_topic_sid ON rfg.rfg_topic USING btree (sport_id);


--
