-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: idx_labw88_template_id
-- Type: INDEX

-- Name: idx_labw88_template_id; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX idx_labw88_template_id ON labw88.labw88_template_component_data USING btree (template_id DESC NULLS LAST);


--
