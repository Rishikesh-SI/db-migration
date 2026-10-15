-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: idx_labsaw_template_id
-- Type: INDEX

-- Name: idx_labsaw_template_id; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE INDEX idx_labsaw_template_id ON labpkl_v1.labpkl_v1_template_component_data USING btree (template_id DESC NULLS LAST);


--
