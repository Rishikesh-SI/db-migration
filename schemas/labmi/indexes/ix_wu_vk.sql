-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: ix_wu_vk
-- Type: INDEX

-- Name: ix_wu_vk; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX ix_wu_vk ON labmi.labmi_web_user USING btree (verification_key);


--
