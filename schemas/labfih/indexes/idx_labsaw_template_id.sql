-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: idx_labsaw_template_id
-- Type: INDEX

-- Name: idx_labsaw_template_id; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX idx_labsaw_template_id ON labfih.labfih_template_component_data USING btree (template_id DESC NULLS LAST);


--
