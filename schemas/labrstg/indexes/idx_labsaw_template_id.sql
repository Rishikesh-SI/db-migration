-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: idx_labsaw_template_id
-- Type: INDEX

-- Name: idx_labsaw_template_id; Type: INDEX; Schema: labrstg; Owner: -
--

CREATE INDEX idx_labsaw_template_id ON labrstg.labrstg_template_component_data USING btree (template_id DESC NULLS LAST);


--
