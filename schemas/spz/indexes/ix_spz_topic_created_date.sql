-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_topic_created_date
-- Type: INDEX

-- Name: ix_spz_topic_created_date; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_topic_created_date ON spz.spz_topic USING btree (created_date);


--
