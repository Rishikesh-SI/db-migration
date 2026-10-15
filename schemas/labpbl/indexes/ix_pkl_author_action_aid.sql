-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: ix_pkl_author_action_aid
-- Type: INDEX

-- Name: ix_pkl_author_action_aid; Type: INDEX; Schema: labpbl; Owner: -
--

CREATE INDEX ix_pkl_author_action_aid ON labpbl.labpbl_author_action USING btree (author_id);


--
