-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: ix_pkl_author_action_aid
-- Type: INDEX

-- Name: ix_pkl_author_action_aid; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE INDEX ix_pkl_author_action_aid ON labpkl_v1.labpkl_v1_author_action USING btree (author_id);


--
