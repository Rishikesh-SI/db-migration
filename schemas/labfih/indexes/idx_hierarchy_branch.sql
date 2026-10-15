-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: idx_hierarchy_branch
-- Type: INDEX

-- Name: idx_hierarchy_branch; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX idx_hierarchy_branch ON labfih.labfih_hierarchy USING btree (branch);


--
