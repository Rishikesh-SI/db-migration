-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: ix_wu_vk
-- Type: INDEX

-- Name: ix_wu_vk; Type: INDEX; Schema: labmi_v1; Owner: -
--

CREATE INDEX ix_wu_vk ON labmi_v1.labmi_v1_web_user USING btree (verification_key);


--
