-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labkxip; Owner: -
--

CREATE INDEX ix_author_action_aid ON labkxip.labkxip_author_action USING btree (author_id);


--
