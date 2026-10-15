-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: idx_labgt_template_id
-- Type: INDEX

-- Name: idx_labgt_template_id; Type: INDEX; Schema: labgt_bkp; Owner: -
--

CREATE INDEX idx_labgt_template_id ON labgt_bkp.labgt_template_component_data USING btree (template_id DESC NULLS LAST);


--
