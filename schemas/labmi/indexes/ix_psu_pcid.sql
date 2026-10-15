-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: ix_psu_pcid
-- Type: INDEX

-- Name: ix_psu_pcid; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX ix_psu_pcid ON labmi.labmi_product_shipment_user USING btree (product_cart_id);


--
