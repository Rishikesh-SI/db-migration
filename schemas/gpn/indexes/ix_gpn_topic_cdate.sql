-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: ix_gpn_topic_cdate
-- Type: INDEX

-- Name: ix_gpn_topic_cdate; Type: INDEX; Schema: gpn; Owner: -
--

CREATE INDEX ix_gpn_topic_cdate ON gpn.gpn_topic USING btree (created_date);


--
