-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: idx_labkxip_template_id
-- Type: INDEX

-- Name: idx_labkxip_template_id; Type: INDEX; Schema: labkxip; Owner: -
--

CREATE INDEX idx_labkxip_template_id ON labkxip.labkxip_template_component_data USING btree (template_id DESC NULLS LAST);


--
