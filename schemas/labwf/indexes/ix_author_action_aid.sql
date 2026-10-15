-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labwf; Owner: -
--

CREATE INDEX ix_author_action_aid ON labwf.labwf_author_action USING btree (author_id);


--
