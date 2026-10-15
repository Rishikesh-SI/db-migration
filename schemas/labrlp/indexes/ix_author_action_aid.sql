-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labrlp; Owner: -
--

CREATE INDEX ix_author_action_aid ON labrlp.labrlp_author_action USING btree (author_id);


--
