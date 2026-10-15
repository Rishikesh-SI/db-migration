-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_topic_sid
-- Type: INDEX

-- Name: ix_gsf_topic_sid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_topic_sid ON gsf.gsf_topic USING btree (sport_id);


--
