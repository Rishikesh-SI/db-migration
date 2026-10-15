-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: idx_labgt_template_id
-- Type: INDEX

-- Name: idx_labgt_template_id; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX idx_labgt_template_id ON labgt.labgt_template_component_data USING btree (template_id DESC NULLS LAST);


--
