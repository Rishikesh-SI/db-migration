-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labkc; Owner: -
--

CREATE INDEX ix_author_action_aid ON labkc.labkc_author_action USING btree (author_id);


--
