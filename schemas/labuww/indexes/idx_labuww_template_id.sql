-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: idx_labuww_template_id
-- Type: INDEX

-- Name: idx_labuww_template_id; Type: INDEX; Schema: labuww; Owner: -
--

CREATE INDEX idx_labuww_template_id ON labuww.labuww_template_component_data USING btree (template_id DESC NULLS LAST);


--
