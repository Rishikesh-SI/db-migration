-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: idx_hierarchy_page_id
-- Type: INDEX

-- Name: idx_hierarchy_page_id; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX idx_hierarchy_page_id ON labfih.labfih_hierarchy USING btree (page_id);


--
