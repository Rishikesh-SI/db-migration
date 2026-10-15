-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: idx_labgt_template_id
-- Type: INDEX

-- Name: idx_labgt_template_id; Type: INDEX; Schema: labgt_02042024; Owner: -
--

CREATE INDEX idx_labgt_template_id ON labgt_02042024.labgt_template_component_data USING btree (template_id DESC NULLS LAST);


--
