-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: idx_labgt01_v1_template_id
-- Type: INDEX

-- Name: idx_labgt01_v1_template_id; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX idx_labgt01_v1_template_id ON labgt01_v1.labgt01_v1_template_component_data USING btree (template_id DESC NULLS LAST);


--
