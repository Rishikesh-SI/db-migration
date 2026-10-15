-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: ix_pcpd_pcid
-- Type: INDEX

-- Name: ix_pcpd_pcid; Type: INDEX; Schema: labmi_v1; Owner: -
--

CREATE INDEX ix_pcpd_pcid ON labmi_v1.labmi_v1_product_cart_paydetails USING btree (product_cart_id);


--
